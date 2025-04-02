--タイム・イーター
function c44913552.initial_effect(c)
	--skip draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc44913552(c44913552,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c44913552.skipcon)
	e2:SetOperation(c44913552.skipop)
	c:RegisterEffect(e2)
end
function c44913552.skipcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_MZONE)
end
function c44913552.skipop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetCode(EFFECT_SKIP_M1)
	e1:SetReset(RESET_PHASE+PHASE_MAIN1+RESET_OPPO_TURN)
	Duel.RegisterEffect(e1,tp)
end