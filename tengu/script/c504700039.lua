--コストダウン
--Cost Down (GOAT)
--The level reset is treated as a continuous effect
function c504700039.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c504700039.cost)
	e1:SetOperation(c504700039.activate)
	c:RegisterEffect(e1)
end
function c504700039.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c504700039.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0):Filter(Card.IsLevelAbove,nil,1)
	local tc=hg:GetFirst()
	local tab={}
	local reset=Effect.CreateEffect(c)
	reset:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	reset:SetCode(EVENT_PHASE+PHASE_END)
	reset:SetCountLimit(1)
	reset:SetOperation(c504700039.resetop)
	reset:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(reset,tp)
	for tc in aux.Next(hg) do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(-2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_PHASE+PHASE_END)
		if tc:RegisterEffect(e1)~=0 then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e2:SetCode(c504700039)
			e2:SetLabelObject(e1)
			e2:SetCondition(c504700039.clearcon(reset))
			e2:SetOperation(c504700039.clearop)
			e2:SetRange(0xff)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2,true)
		end
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_HAND)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetOperation(c504700039.hlvop(reset))
	Duel.RegisterEffect(e2,tp)
end
function c504700039.resetop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseEvent(e:GetHandler(),c504700039,e,0,0,0,0)
end
function c504700039.clearcon(reset)
	return function(e,tp,eg,ep,ev,re,r,rp)
		return re==reset
	end
end
function c504700039.clearop(e)
	e:GetLabelObject():Reset()
	e:Reset()
end
function c504700039.hlvfilter(c,tp)
	return c:IsLevelAbove(1) and c:IsControler(tp)
end
function c504700039.hlvop(reset)
	return function(e,tp,eg,ep,ev,re,r,rp)
		local hg=eg:Filter(c504700039.hlvfilter,nil,tp)
		local tc=hg:GetFirst()
		for tc in aux.Next(hg) do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_LEVEL)
			e1:SetValue(-2)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_PHASE+PHASE_END)
			if tc:RegisterEffect(e1)~=0 then
				local e2=Effect.CreateEffect(e:GetHandler())
				e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
				e2:SetCode(c504700039)
				e2:SetLabelObject(e1)
				e2:SetCondition(c504700039.clearcon(reset))
				e2:SetOperation(c504700039.clearop)
				e2:SetRange(0xff)
				e2:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_PHASE+PHASE_END)
				tc:RegisterEffect(e2,true)
			end
		end
	end
end