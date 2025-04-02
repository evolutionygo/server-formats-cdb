--イマイルカ
--Imairuka
function c41952656.initial_effect(c)
	--Send the top card of your Deck to the GY, then, if it is a WATER monster, draw 1 card
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc41952656(c41952656,0))
	e1:SetCategory(CATEGORY_DECKDES+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c41952656.tgcon)
	e1:SetTarget(c41952656.tgtg)
	e1:SetOperation(c41952656.tgop)
	c:RegisterEffect(e1)
end
function c41952656.tgcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp==1-tp and c:IsReason(REASON_DESTROY) and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c41952656.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
	Duel.SetPossibleOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c41952656.tgop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardDeck(tp,1,REASON_EFFECT)==1 then
		local sc=Duel.GetOperatedGroup():GetFirst()
		if sc:IsAttribute(ATTRIBUTE_WATER) and sc:IsLocation(LOCATION_GRAVE) and Duel.IsPlayerCanDraw(tp) then
			Duel.BreakEffect()
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end