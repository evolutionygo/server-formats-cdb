--言語道断侍
--Sasuke Samurai #2 (GOAT)
--Cards can be activated during the end phase
function c504700016.initial_effect(c)
	--act limit
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc504700016(c504700016,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c504700016.cost)
	e1:SetTarget(c504700016.target)
	e1:SetOperation(c504700016.operation)
	c:RegisterEffect(e1)
end
function c504700016.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)
end
function c504700016.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,c504700016)==0 end
end
function c504700016.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetDescription(aux.Stringc504700016(c504700016,1))
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,1)
	e1:SetValue(c504700016.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetCondition(function() return Duel.GetCurrentPhase()==PHASE_END end)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetOperation(function(e) e1:Reset() e:Reset() end)
	Duel.RegisterEffect(e2,tp)
	Duel.RegisterFlagEffect(tp,c504700016,RESET_PHASE+PHASE_END,0,1)
end
function c504700016.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end