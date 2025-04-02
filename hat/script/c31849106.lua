--異次元グランド
--Different Dimension Ground
function c31849106.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c31849106.activate)
	e1:SetCost(c31849106.cost)
	c:RegisterEffect(e1)
end
function c31849106.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,c31849106)==0 end
end
function c31849106.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e1:SetTarget(c31849106.rmtarget)
	e1:SetTargetRange(0xff,0xff)
	e1:SetValue(LOCATION_REMOVED)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,c31849106,RESET_PHASE+PHASE_END,0,1)
end
function c31849106.rmtarget(e,c)
	return not c:IsLocation(0x80) and not c:IsSpellTrap() and Duel.IsPlayerCanRemove(e:GetHandlerPlayer(),c)
end