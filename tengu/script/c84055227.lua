--ゲイシャドウ
--Mac84055227en of Macabre
function c84055227.initial_effect(c)
	c:EnableCounterPermit(COUNTER_SPELL)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc84055227(c84055227,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c84055227.condition)
	e1:SetOperation(c84055227.operation)
	c:RegisterEffect(e1)
	--attackup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c84055227.attackup)
	c:RegisterEffect(e2)
end
c84055227.counter_list={COUNTER_SPELL}
function c84055227.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:GetBattleTarget():IsMonster()
end
function c84055227.operation(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(COUNTER_SPELL,1)
end
function c84055227.attackup(e,c)
	return c:GetCounter(COUNTER_SPELL)*200
end