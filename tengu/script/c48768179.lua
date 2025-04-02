--黒蠍－強力のゴーグ
--Dark Scorpion - Gorg the Strong
function c48768179.initial_effect(c)
	--Activate 1 of these effects
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc48768179(c48768179,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp) return ep==1-tp end)
	e1:SetTarget(c48768179.efftg)
	e1:SetOperation(c48768179.effop)
	c:RegisterEffect(e1)
end
function c48768179.efftg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToDeck() end
	local b1=Duel.IsExistingTarget(Card.IsAbleToDeck,tp,0,LOCATION_MZONE,1,nil)
	local b2=Duel.IsPlayerCanDiscardDeck(1-tp,1)
	if chk==0 then return b1 or b2 end
	local op=Duel.SelectEffect(tp,
		{b1,aux.Stringc48768179(c48768179,1)},
		{b2,aux.Stringc48768179(c48768179,2)})
	e:SetLabel(op)
	if op==1 then
		e:SetCategory(CATEGORY_TODECK)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,0,LOCATION_MZONE,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,tp,0)
	else
		e:SetCategory(CATEGORY_DECKDES)
		e:SetProperty(0)
		Duel.SetOperationInfo(0,CATEGORY_DECKDES,0,0,1-tp,1)
	end
end
function c48768179.effop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==1 then
		--Return 1 monster your opponent controls to the top of the Deck
		local tc=Duel.GetFirstTarget()
		if not (tc:IsRelateToEffect(e) and tc:IsControler(1-tp)) then return end
		Duel.SendtoDeck(tc,nil,SEQ_DECKTOP,REASON_EFFECT)
	else
		--Send the top card of your opponent's Deck to the GY
		Duel.DiscardDeck(1-tp,1,REASON_EFFECT)
	end
end