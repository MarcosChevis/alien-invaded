//
//  Portal.swift
//  AvianInvaded iOS
//
//  Created by Gabriel Ferreira de Carvalho on 23/03/22.
//
import SpriteKit
import Combine

final class Portal: SKNode {
    private let sprite: SKSpriteNode
    private let direction: RoomDirection
    private var cancellables: Set<AnyCancellable>
    private var isActive: Bool
    private var lightNode: SKLightNode = .init()
    
    private lazy var portalTexture: [SKTexture] = {
        SKTexture.loadCyclicalFromAtlas(named: "Portal")
    }()
    
    weak var delegate: PortalDelegate?
    
    init(direction: RoomDirection, spriteSize: CGSize) {
        let texture = SKTexture(imageNamed: "Portal_5")
        self.sprite = SKSpriteNode(texture: texture, color: .clear, size: spriteSize)
        self.isActive = false
        self.direction = direction
        self.cancellables = .init()
        super.init()
        
        setupSpriteOnScene(spriteSize: spriteSize)
        setupColision(spriteSize: spriteSize)
        setupBindings()
        
        self.lightNode.ambientColor = .init(white: 0.2, alpha: 1)
        self.lightNode.lightColor = .cyan.withAlphaComponent(0.2)
        self.lightNode.falloff = 0.5
        self.lightNode.zPosition = 10
        
        lightNode.categoryBitMask = ColisionGroup.getCategotyMask(.light)
        lightNode.zPosition = 3
        lightNode.position = CGPoint(x: -spriteSize.width/2, y: -spriteSize.width/2)
        
        self.addChild(lightNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSpriteOnScene(spriteSize: CGSize) {
        addChild(sprite)
        sprite.position = CGPoint(x: sprite.position.x - spriteSize.width/2,
                                  y: sprite.position.y - spriteSize.height/2)
        
        let action = SKAction.rotate(byAngle: direction.angle, duration: 0)
        sprite.run(action)
    }
    
    private func setupColision(spriteSize: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 10), center: sprite.position)
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        colisionGroup = .portal
        physicsBody?.contactTestBitMask = ColisionGroup.getContactMask(colisionGroup)
        physicsBody?.collisionBitMask = ColisionGroup.getCollisionMask(colisionGroup)
        physicsBody?.categoryBitMask = ColisionGroup.getCategotyMask(colisionGroup)
        self.sprite.lightingBitMask = ColisionGroup.getLightMask(colisionGroup)
        

    }
    
    private func setupBindings() {
        NotificationCenter
            .default
            .publisher(for: .shouldActivatePortals)
            .sink(receiveValue: shouldActivatePortal)
            .store(in: &cancellables)
    }
    
    private func shouldActivatePortal(_ notification: Notification) {
        isActive = true
        runActivePortalAnimation()
    }
    
    private func runActivePortalAnimation() {
        let timePerFrame: TimeInterval = 1.5/Double(portalTexture.count)
        let action = SKAction.repeatForever(SKAction.animate(with: portalTexture,
                                                             timePerFrame: timePerFrame,
                                                             resize: false,
                                                             restore: true))
        sprite.run(action)
    }
}

extension Portal: Contactable {
    func contact(with colisionGroup: ColisionGroup) {
        if isActive {
            delegate?.teleport(to: direction)
            isActive = false
        }
    }
}
