beatem = 0
beatem1 = 0
lastStep = 0
flipped = false
hpToTake = 0
startHealth = 0
toHealth = 0
lerpPercent = 0
gremduration = 0
perc = 0
loopsCompleted = 0
onc = false
interupt = false
grabbed = false

function onCreate()
	 precacheImage('HP GREMLIN');
	 precacheImage('Minion1');
 	 precacheImage('Tentacle1');
end

function gremlinevent(hpToTake, duration)
    gremduration = duration
    interupt = false
    grabbed = true
    
    if downscroll == true then
        setProperty('HPGremlin.flipY', true)
        gremlinflip = getProperty('HPGremlin.y') - 150
        setProperty('HPGremlin.y', gremlinflip)
    end
    addLuaSprite('HPGremlin', true)
    setPropertyLuaSprite('HPGremlin', 'alpha', 0)
    setLuaSpriteCamera('HPGremlin', 'camHUD')
    startHealth = getProperty('health')
    toHealth = (hpToTake / 100) * startHealth
    --debugPrint('tohealth = ', toHealth)
    perc = toHealth / 2 * 100
    --debugPrint('perc = ', perc)
    onc = false

    setPropertyLuaSprite('HPGremlin', 'alpha', 1)
    playSound('GremlinWoosh')
    luaSpritePlayAnimation('HPGremlin', 'come')
    runTimer('gremlingrab', 0.14, 1)
    
end

function minionevent(hpToTake, duration)
    gremduration = duration
    interupt = false
    grabbed = true
    
    if downscroll == true then
        setProperty('Minion.flipY', true)
        minionflip = getProperty('Minion.y') - 150
        setProperty('Minion.y', minionflip)
    end
    addLuaSprite('Minion', true)
    setPropertyLuaSprite('Minion', 'alpha', 0)
    setLuaSpriteCamera('Minion', 'camHUD')
    startHealth = getProperty('health')
    toHealth = (hpToTake / 100) * startHealth
    --debugPrint('tohealth = ', toHealth)
    perc = toHealth / 2 * 100
    --debugPrint('perc = ', perc)
    onc = false

    setPropertyLuaSprite('Minion', 'alpha', 1)
    playSound('GremlinWoosh')
    luaSpritePlayAnimation('Minion', 'come')
    runTimer('miniongrab', 0.14, 1)
    
end

function tevent(hpToTake, duration)
    gremduration = duration
    interupt = false
    grabbed = true
    
    if downscroll == true then
        setProperty('T.flipY', true)
        Tflip = getProperty('T.y') - 150
        setProperty('T.y', Tflip)
    end
    addLuaSprite('T', true)
    setPropertyLuaSprite('T', 'alpha', 0)
    setLuaSpriteCamera('T', 'camHUD')
    startHealth = getProperty('health')
    toHealth = (hpToTake / 50) * startHealth
    --debugPrint('tohealth = ', toHealth)
    perc = toHealth / 1 * 50
    --debugPrint('perc = ', perc)
    onc = false

    setPropertyLuaSprite('T', 'alpha', 1)
    luaSpritePlayAnimation('T', 'come')
    runTimer('tgrab', 0.14, 1)
    
end

songEvents = {
    [1] = function()
        gremlinx = getProperty('iconP1.x')
        gremliny = getProperty('healthBarBG.y') - 215
        makeAnimatedLuaSprite('HPGremlin', 'HP GREMLIN', gremlinx, gremliny);
        luaSpriteAddAnimationByIndices('HPGremlin', 'come', 'HP Gremlin ANIMATION', '0,1')
        luaSpriteAddAnimationByIndices('HPGremlin', 'grab', 'HP Gremlin ANIMATION', '2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24')
        luaSpriteAddAnimationByIndices('HPGremlin', 'hold', 'HP Gremlin ANIMATION', '25,26,27,28')
        luaSpriteAddAnimationByIndices('HPGremlin', 'release', 'HP Gremlin ANIMATION', '29,30,31,32,33')
        scaleLuaSprite('HPGremlin', 0.7, 0.7);

	mx = getProperty('iconP1.x')
        my = getProperty('healthBarBG.y') - 215
        makeAnimatedLuaSprite('Minion', 'Minion1', mx, my);
        luaSpriteAddAnimationByIndices('Minion', 'come', 'MinionAttack1', '0,1')
        luaSpriteAddAnimationByIndices('Minion', 'grab', 'MinionAttack1', '2,3,4,5,6,7,8,9,10,11,12,13,14,15,16')
        luaSpriteAddAnimationByIndices('Minion', 'hold', 'MinionFail1', '0,1,2,3,4,5,6,7,8')
        luaSpriteAddAnimationByIndices('Minion', 'release', 'MinionFail1', '0,1,2,3,4,5,6,7,8')
        scaleLuaSprite('Minion', 0.7, 0.7);

	tx = getProperty('iconP1.x')
        ty = getProperty('healthBarBG.y') - 215
        makeAnimatedLuaSprite('T', 'Tentacle1', mx, my);
        luaSpriteAddAnimationByIndices('T', 'come', 'START', '0,1,2,3,4,5,6,7,8,9,10,11')
        luaSpriteAddAnimationByIndices('T', 'grab', 'PUSH', '0')
        luaSpriteAddAnimationByIndices('T', 'hold', 'HOLD', '0,1,2,3')
        luaSpriteAddAnimationByIndices('T', 'release', 'HOLD', '0,1,2,3')
        scaleLuaSprite('T', 1, 1);
    end,
    [832] = function()
        tevent(40, 3)
    end,

    [932] = function()
        tevent(40, 3)
    end,

    [1068] = function()
        tevent(40, 3)
    end,

    [1150] = function()
        tevent(40, 3)
    end,

    [1225] = function()
        tevent(40, 3)
    end,

        [1572] = function()
        tevent(40, 3)
    end,

        [1225] = function()
        tevent(40, 3)
    end,

}
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'hpDrain' then
        loopsCompleted = loopsCompleted + 1
        health = getProperty('health')
        --debugPrint(health)
        if health <= 0 then
            setProperty('health', -500)
        end
        luaSpritePlayAnimation('HPGremlin', 'hold')
        if(interupt == true and onc == false) then
            onc = true
            loopsCompleted = 0
            cancelTween('gremlinholding')
            
            luaSpritePlayAnimation('HPGremlin', 'release')
            runTimer('releaseTimer', 0.15, 1)
            cancelTimer('hpDrain')
        end
        if(interupt == false) then
            loopPercent = loopsCompleted / loops
            --debugPrint(loopPercent)
            hplerp = lerp(startHealth, toHealth, loopPercent)
            setProperty('health', hplerp)
        end
	end

    if tag == 'gremlingrab' then
        luaSpritePlayAnimation('HPGremlin', 'grab')
        gremtween = getProperty('iconP1.x')
        remapToRange = 100 + (perc - 0) * (0 - 100) / (100 - 0)
        hpBarX = getProperty('healthBar.x')
        hpBarwidth = getProperty('healthBar.width')
        tweenlength = (hpBarX + (hpBarwidth * (remapToRange * 0.01) - 26)) - 75
        doTweenX('gremlingrabbing', 'HPGremlin', gremtween, 1, 'elasticIn')
        
    end

    if tag == 'releaseTimer' then
        removeLuaSprite('HPGremlin', false)
    end

	if tag == 'hpDrain2' then
        loopsCompleted = loopsCompleted + 1
        health = getProperty('health')
        --debugPrint(health)
        if health <= 0 then
            setProperty('health', -500)
        end
        luaSpritePlayAnimation('Minion', 'hold')
        if(interupt == true and onc == false) then
            onc = true
            loopsCompleted = 0
            cancelTween('gremlinholding')
            
            luaSpritePlayAnimation('Minion', 'release')
            runTimer('releaseTimer2', 0.15, 1)
            cancelTimer('hpDrain2')
        end
        if(interupt == false) then
            loopPercent = loopsCompleted / loops
            --debugPrint(loopPercent)
            hplerp = lerp(startHealth, toHealth, loopPercent)
            setProperty('health', hplerp)
        end
	end

    if tag == 'miniongrab' then
        luaSpritePlayAnimation('Minion', 'grab')
        gremtween = getProperty('iconP1.x')
        remapToRange = 100 + (perc - 0) * (0 - 100) / (100 - 0)
        hpBarX = getProperty('healthBar.x')
        hpBarwidth = getProperty('healthBar.width')
        tweenlength = (hpBarX + (hpBarwidth * (remapToRange * 0.01) - 26)) - 75
        doTweenX('miniongrabbing', 'Minion', gremtween, 1, 'elasticIn')
        
    end

    if tag == 'releaseTimer2' then
        removeLuaSprite('Minion', false)
    end

        if tag == 'hpDrain3' then
        loopsCompleted = loopsCompleted + 1
        health = getProperty('health')
        --debugPrint(health)
        if health <= 0 then
            setProperty('health', -500)
        end
        luaSpritePlayAnimation('T', 'hold')
        if(interupt == true and onc == false) then
            onc = true
            loopsCompleted = 0
            cancelTween('gremlinholding')
            
            luaSpritePlayAnimation('T', 'release')
            runTimer('releaseTimer3', 0.15, 1)
            cancelTimer('hpDrain3')
        end
        if(interupt == false) then
            loopPercent = loopsCompleted / loops
            --debugPrint(loopPercent)
            hplerp = lerp(startHealth, toHealth, loopPercent)
            setProperty('health', hplerp)
        end
	end

    if tag == 'tgrab' then
        luaSpritePlayAnimation('T', 'grab')
        gremtween = getProperty('iconP1.x')
        remapToRange = 100 + (perc - 0) * (0 - 100) / (100 - 0)
        hpBarX = getProperty('healthBar.x')
        hpBarwidth = getProperty('healthBar.width')
        tweenlength = (hpBarX + (hpBarwidth * (remapToRange * 0.01) - 26)) - 75
        doTweenX('tgrabbing', 'T', gremtween, 1, 'elasticIn')
        
    end

    if tag == 'releaseTimer3' then
        removeLuaSprite('T', false)
    end

end

function onTweenCompleted(tag)
    if tag == 'gremlingrabbing' then
        luaSpritePlayAnimation('HPGremlin', 'hold')
        timerDuration = gremduration / 0.1
        doTweenX('gremlinholding', 'HPGremlin', tweenlength, gremduration)
        runTimer('hpDrain', 0.1, timerDuration)
        
    end

    if tag == 'gremlinholding' then
        loopsCompleted = 0
        cancelTimer('hpDrain')
        if interupt == true then
            removeLuaSprite('HPGremlin', false)
            grabbed = false
        else
            luaSpritePlayAnimation('HPGremlin', 'release')
            runTimer('releaseTimer', 0.15, 1)
            grabbed = false
        end
    end
	 if tag == 'miniongrabbing' then
        luaSpritePlayAnimation('Minion', 'hold')
        timerDuration = gremduration / 0.1
        doTweenX('minionholding', 'Minion', tweenlength, gremduration)
        runTimer('hpDrain2', 0.1, timerDuration)
        
    end

    if tag == 'minionholding' then
        loopsCompleted = 0
        cancelTimer('hpDrain2')
        if interupt == true then
            removeLuaSprite('Minion', false)
            grabbed = false
        else
            luaSpritePlayAnimation('Minion', 'release')
            runTimer('releaseTimer2', 0.15, 1)
            grabbed = false
        end
    end
 if tag == 'tgrabbing' then
        luaSpritePlayAnimation('T', 'hold')
        timerDuration = gremduration / 0.1
        doTweenX('tholding', 'T', tweenlength, gremduration)
        runTimer('hpDrain3', 0.1, timerDuration)
        
    end

    if tag == 'tholding' then
        loopsCompleted = 0
        cancelTimer('hpDrain3')
        if interupt == true then
            removeLuaSprite('T', false)
            grabbed = false
        else
            luaSpritePlayAnimation('T', 'release')
            runTimer('releaseTimer3', 0.15, 1)
            grabbed = false
        end
    end
end

function lerp(pos1, pos2, perc)
    --return (1-perc) * pos1 + perc*pos2
    return pos1 + ((pos2 - pos1) * perc)
end

function onStepHit()
    if curStep ~= lastStep then
        if songEvents[curStep] then
            songEvents[curStep]()
        end
        lastStep = curStep
    end
end