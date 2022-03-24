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
    
    weak var delegate: PortalDelegate?
    
    init(direction: RoomDirection, spriteSize: CGSize) {
        let texture = SKTexture(imageNamed: "Portal")
        self.sprite = SKSpriteNode(texture: texture, color: .clear, size: spriteSize)
        self.isActive = false
        self.direction = direction
        self.cancellables = .init()
        super.init()
        
        setupSpriteOnScene(spriteSize: spriteSize)
        setupColision(spriteSize: spriteSize)
        setupBindings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSpriteOnScene(spriteSize: CGSize) {
        addChild(sprite)
        sprite.position = CGPoint(x: sprite.position.x - spriteSize.width/2,
                                  y: sprite.position.y - spriteSize.height/2)
    }
    
    private func setupColision(spriteSize: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOf: spriteSize, center: sprite.position)
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        colisionGroup = .portal
        physicsBody?.contactTestBitMask = ColisionGroup.getContactMask(colisionGroup)
        physicsBody?.collisionBitMask = ColisionGroup.getCollisionMask(colisionGroup)
        physicsBody?.categoryBitMask = ColisionGroup.getCategotyMask(colisionGroup)
    }
    
    private func setupBindings() {
        NotificationCenter
            .default
            .publisher(for: .shouldActivatePortals)
            .sink { [weak self] _ in self?.isActive = true }
            .store(in: &cancellables)
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
