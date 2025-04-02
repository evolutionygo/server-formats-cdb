--黒蠍－罠はずしのクリフ
--Dark Scorpion - Cliff the Trap Remover
function c6967870.initial_effect(c)
	--Activate 1 of these effects
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc6967870(c6967870,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp) return ep==1-tp end)
	e1:SetTarget(c6967870.efftg)
	e1:SetOperation(c6967870.effop)
	c:RegisterEffect(e1)
end
function c6967870.efftg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsSpellTrap() end
	local b1=Duel.IsExistingTarget(Card.IsSpellTrap,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
	local b2=Duel.IsPlayerCanDiscardDeck(1-tp,2)
	if chk==0 then return b1 or b2 end
	local op=Duel.SelectEffect(tp,
		{b1,aux.Stringc6967870(c6967870,1)},
		{b2,aux.Stringc6967870(c6967870,2)})
	e:SetLabel(op)
	if op==1 then
		e:SetCategory(CATEGORY_DESTROY)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectTarget(tp,Card.IsSpellTrap,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	else
		e:SetCategory(CATEGORY_DECKDES)
		e:SetProperty(0)
		Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,2)
	end
end
function c6967870.effop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==1 then
		--Destroy 1 Spell/Trap on the field
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	else
		--Send the top 2 cards of your opponent's Deck to the GY
		Duel.DiscardDeck(1-tp,2,REASON_EFFECT)
	end
end