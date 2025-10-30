local cm,m=GetID()
local list={120247005,120207007}
cm.name="鹰身女郎2·3"
function cm.initial_effect(c)
	RD.AddCodeList(c,list)
	--Fusion Material
	RD.AddFusionProcedure(c,list[1],cm.matfilter)
	--Contact Fusion
	RD.EnableContactFusion(c,aux.Stringid(m,0))
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
	--Continuous Effect
	RD.AddContinuousEffect(c,e1,e2,e3,RD.EnableChangeCode(c,list[2],LOCATION_MZONE))
end
--Fusion Material
cm.unspecified_funsion=true
function cm.matfilter(c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_WINDBEAST)
end
--Cannot Activate
function cm.limfilter(c,tp)
	return c:IsFaceup() and c:IsSummonPlayer(tp)
end
function cm.limcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(cm.limfilter,1,nil,tp)
end
function cm.limop1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentChain()==0 then
		Duel.SetChainLimitTillChainEnd(cm.chainlm)
	elseif Duel.GetCurrentChain()==1 then
		local c=e:GetHandler()
		c:RegisterFlagEffect(20279003,RESET_EVENT+RESETS_STANDARD,0,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAINING)
		e1:SetOperation(cm.resetop)
		Duel.RegisterEffect(e1,tp)
	end
end
function cm.limop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(20279003)~=0 then
		Duel.SetChainLimitTillChainEnd(cm.chainlm)
	end
	c:ResetFlagEffect(20279003)
end
function cm.chainlm(e,ep,tp)
	return not (ep~=tp and e:GetHandler():IsType(TYPE_TRAP) and e:IsHasType(EFFECT_TYPE_ACTIVATE))
end
function cm.resetop(e)
	e:GetHandler():ResetFlagEffect(20279003)
	e:Reset()
end