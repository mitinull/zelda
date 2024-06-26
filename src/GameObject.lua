--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class {}

function GameObject:init(def, x, y)
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid
    self.consumable = def.consumable

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    self.destroyed = false

    -- default empty collision callback
    self.onCollide = function() end
end

function GameObject:update(dt)
    if self.speed then
        if self.direction == 'left' then
            self.x = self.x - self.speed * dt
        elseif self.direction == 'right' then
            self.x = self.x + self.speed * dt
        elseif self.direction == 'up' then
            self.y = self.y - self.speed * dt
        elseif self.direction == 'down' then
            self.y = self.y + self.speed * dt
        end
    end
end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture],
        gFrames[self.texture][self.state and self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end

function GameObject:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
        self.y + self.height < target.y or self.y > target.y + target.height)
end

function GameObject:destroy()
    gSounds['break']:play()
    self.state = 'broken'
    self.hitWall = true
    self.speed = 0
    Timer.after(1, function()
        self.destroyed = true
    end)
end
