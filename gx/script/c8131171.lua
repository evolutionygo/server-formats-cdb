--キラー・スネーク
--Sinister Serpent
function c8131171.initial_effect(c)
	--Add this card to the hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc8131171(c8131171,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,c8131171)
	e1:SetCondition(function(_,tp) return Duel.IsTurnPlayer(tp) end)
	e1:SetTarget(c8131171.target)
	e1:SetOperation(c8131171.operation)
	c:RegisterEffect(e1)
end
c8131171.listed_names={c8131171}
function c8131171.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,c,1,tp,0)
	Duel.SetPossibleOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_GRAVE)
end
function c8131171.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
	--Banish 1 "Sinister Serpent" from your GY during the opponent's next End Phase
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetCondition(c8131171.rmcon)
	e1:SetOperation(c8131171.rmop)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	Duel.RegisterEffect(e1,tp)
end
function c8131171.rmfilter(c)
	return c:IsCode(c8131171) and c:IsAbleToRemove() and aux.SpElimFilter(c,true)
end
function c8131171.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsTurnPlayer(1-tp) and Duel.IsExistingMatchingCard(c8131171.rmfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil)
end
function c8131171.rmop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c8131171.rmfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil)
	if #g==0 then return end
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end