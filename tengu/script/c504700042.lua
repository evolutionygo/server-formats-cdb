--不幸を告げる黒猫
function c504700042.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c504700042.operation)
	c:RegisterEffect(e1)
end
c504700042.listed_names={CARD_NECROVALLEY}
function c504700042.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringc504700042(c504700042,1))
	local g=Duel.SelectMatchingCard(tp,Card.IsTrap,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		if Duel.IsEnvironment(CARD_NECROVALLEY) and tc:IsAbleToHand() and Duel.SelectYesNo(tp,aux.Stringc504700042(c504700042,0)) then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		else
			Duel.ShuffleDeck(tp)
			Duel.MoveSequence(tc,0)
			Duel.ConfirmDecktop(tp,1)
		end
	else
		Duel.GoatConfirm(tp,LOCATION_DECK)
	end
end