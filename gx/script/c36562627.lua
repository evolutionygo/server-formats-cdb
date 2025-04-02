--セカンド・チャンス
--Second Coin Toss
function c36562627.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--Redo your coin toss
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TOSS_COIN_NEGATE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCondition(c36562627.coincon)
	e1:SetOperation(c36562627.coinop)
	c:RegisterEffect(e1)
end
function c36562627.coincon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and not Duel.HasFlagEffect(tp,c36562627)
end
function c36562627.coinop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.HasFlagEffect(tp,c36562627) then return end
	if Duel.SelectEffectYesNo(tp,e:GetHandler()) then
		Duel.Hint(HINT_CARD,0,c36562627)
		Duel.RegisterFlagEffect(tp,c36562627,RESET_PHASE|PHASE_END,0,1)
		Duel.TossCoin(tp,ev)
	end
end