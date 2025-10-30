local cm,m=GetID()
cm.name="魔力动物双剑士"
function cm.initial_effect(c)
	--Cannot Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(cm.limcon)
	e1:SetOperation(cm.limop1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetOperation(cm.limop2)
	c:RegisterEffect(e3)
	--Level Up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_LEVEL)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetTarget(cm.target)
	e4:SetValue(2)
	c:RegisterEffect(e4)
	--Continuous Effect
	RD.AddContinuousEffect(c,e1,e2,e3,e4)
end
--Cannot Activate
function cm.limfilter(c,tp)
	return c:IsFaceup() and c:IsSummonPlayer(tp) and c:IsRace(RACE_BEAST)
end
function cm.limcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(cm.limfilter,1,nil,tp)
end
function cm.limop1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentChain()==0 then
		Duel.SetChainLimitTillChainEnd(cm.chainlm)
	elseif Duel.GetCurrentChain()==1 then
		local c=e:GetHandler()
		c:RegisterFlagEffect(20277030,RESET_EVENT+RESETS_STANDARD,0,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAINING)
		e1:SetOperation(cm.resetop)
		Duel.RegisterEffect(e1,tp)
	end
end
function cm.limop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(20277030)~=0 then
		Duel.SetChainLimitTillChainEnd(cm.chainlm)
	end
	c:ResetFlagEffect(20277030)
end
function cm.chainlm(e,ep,tp)
	return not (ep~=tp and e:GetHandler():IsType(TYPE_TRAP) and e:IsHasType(EFFECT_TYPE_ACTIVATE))
end
function cm.resetop(e)
	e:GetHandler():ResetFlagEffect(20277030)
	e:Reset()
end
--Level Up
function cm.target(e,c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_BEAST)
end