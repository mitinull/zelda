--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerThrowState = Class { __includes = EntityIdleState }

function PlayerThrowState:enter(params)
    self.entity:changeAnimation('throw-' .. self.entity.direction)
    self.pot = params.pot
    gSounds['throw']:play()
end

function PlayerThrowState:update(dt)
    if self.entity.currentAnimation.currentFrame == 2 then
        local throwDuration = 0.5

        self.pot.direction = self.entity.direction
        self.pot.speed = TILE_SIZE * 4 / throwDuration

        Timer.after(throwDuration, function()
            if not self.pot.hitWall then
                self.pot.destroyed = true
            end
        end)
    end
    if self.entity.currentAnimation.currentFrame >= #self.entity.currentAnimation.frames then
        self.pot.thrown = true
        self.entity.currentAnimation:refresh()
        self.entity:changeState('idle')
    end
end
