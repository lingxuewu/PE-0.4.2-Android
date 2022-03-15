function onCreate(elapsed)
health = getProperty('health')
if getProperty('health') == 2 then
setProperty('healthBar.visible', false);
setProperty('healthBarBG.visible', false);
setProperty('iconP1.visible', false);
setProperty('iconP2.visible', false);
elseif getProperty('health') <= 1.99 then
setProperty('healthBar.visible', true);
setProperty('healthBarBG.visible', true);
setProperty('iconP1.visible', true);
setProperty('iconP2.visible', true);
end end