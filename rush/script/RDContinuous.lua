-- Rush Duel 永续效果
RushDuel = RushDuel or {}

-- 添加永续效果列表
function RushDuel.AddContinuousEffect(c, ...)
    if c:IsStatus(STATUS_COPYING_EFFECT) then
        return
    end
    if c.continuous_effect == nil then
        local mt = getmetatable(c)
        mt.continuous_effect = {...}
    else
        for _, e in ipairs {...} do
            table.insert(c.continuous_effect, e)
        end
    end
end

-- 永续效果: 攻击宣言时, 对方不能把陷阱卡发动
function RushDuel.ContinuousAttackNotChainTrap(card)
    local e1 = Effect.CreateEffect(card)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_ATTACK_ANNOUNCE)
    e1:SetLabel(card:GetOriginalCode())
    e1:SetOperation(RushDuel.AttackNotChainTrapOperation)
    card:RegisterEffect(e1)
    return e1
end
function RushDuel.AttackNotChainTrapOperation(e, tp, eg, ep, ev, re, r, rp)
    Duel.Hint(HINT_CARD, 0, e:GetLabel())
    Duel.SetChainLimitTillChainEnd(RushDuel.AttachAttackNotChainTrapLimit)
end
function RushDuel.AttachAttackNotChainTrapLimit(e, rp, tp)
    return not (rp ~= tp and e:IsHasType(EFFECT_TYPE_ACTIVATE) and e:IsActiveType(TYPE_TRAP))
end

-- 永续效果: 战斗破坏怪兽送去墓地时的处理
function RushDuel.ContinuousBattleDestroyToGrave(card, condition, operation, register)
    local e1 = Effect.CreateEffect(card)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_BATTLE_DESTROYING)
    e1:SetCondition(RushDuel.BattleDestroyToGraveCondition(condition))
    e1:SetOperation(RushDuel.BattleDestroyToGraveOperation(operation))
    if register ~= false then
        card:RegisterEffect(e1)
    end
    return e1
end
function RushDuel.BattleDestroyToGraveCondition(condition)
    return function(e, tp, eg, ep, ev, re, r, rp)
        local c = e:GetHandler()
        local tc = c:GetBattleTarget()
        return c:IsRelateToBattle() and tc:IsLocation(LOCATION_GRAVE) and tc:IsType(TYPE_MONSTER) and (not condition or condition(e, tp, eg, ep, ev, re, r, rp))
    end
end
function RushDuel.BattleDestroyToGraveOperation(operation)
    return function(e, tp, eg, ep, ev, re, r, rp)
        local tc = e:GetHandler():GetBattleTarget()
        operation(e, tp, eg, ep, ev, re, r, rp, tc)
    end
end
