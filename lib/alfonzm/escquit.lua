--
-- escquit
-- by Alphonsus
--
-- Usage:
--	Add escquit:update(k) to love.keypressed(k)
--

escquit = {}

function escquit:update(k)
	if k == 'escape' then
		love.event.push('quit')
	end
end

return escquit