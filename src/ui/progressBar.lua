function createProgressBar(x,y,value,maxValue,showText,width,height,color, textX, textY)
    local progressBar = {
        x = x or 0,
        y = y or 0,
        value = value or 0,
        maxValue = maxValue or 100,
        width = width or 100,
        height = height or 20,
        textX = textX or 5,
        textY = textY or 3,

        showText = showText or false,

        color = color or {1,1,1},

        addValue = function(self, value)
            if self.value + value >= self.maxValue then
                self.value = self.maxValue
            elseif self.value + value <= 0 then
                self.value = 0
            else
                self.value = self.value + value
            end
        end,

        isFull = function(self)
            return self.value == self.maxValue
        end,

        ifEmpty = function (self)
            return self.value == 0
        end,

        showTextToggle = function (self)
            self.showText = not self.showText
            if self.showText then
                self.draw = function(self)
                    love.graphics.setColor(self.color)
                    love.graphics.rectangle('fill', self.x, self.y, self.width * (self.value/self.maxValue), self.height)
                    love.graphics.setColor(1,1,1)
                    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
                    love.graphics.print(value, self.x + self.textX, self.y + self.textY)
                end
            else
                self.draw = function(self)
                    love.graphics.setColor(self.color)
                    love.graphics.rectangle('fill', self.x, self.y, self.width * (self.value/self.maxValue), self.height)
                    love.graphics.setColor(1,1,1)
                    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
                end
            end
        end
    }
    if progressBar.showText then
        progressBar.draw = function(self)
            love.graphics.setColor(self.color)
            love.graphics.rectangle('fill', self.x, self.y, self.width * (self.value/self.maxValue), self.height)
            love.graphics.setColor(1,1,1)
            love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
            love.graphics.print(value, self.x + self.textX, self.y + self.textY)
        end
    else
        progressBar.draw = function(self)
            love.graphics.setColor(self.color)
            love.graphics.rectangle('fill', self.x, self.y, self.width * (self.value/self.maxValue), self.height)
            love.graphics.setColor(1,1,1)
            love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
        end
    end
    
    return progressBar
end