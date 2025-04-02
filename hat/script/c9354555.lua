--フォトン・ベール
--Photon Veil
function c9354555.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c9354555.target)
	e1:SetOperation(c9354555.activate)
	c:RegisterEffect(e1)
end
function c9354555.tdfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToDeck()
end
function c9354555.thfilter(c)
	return c:IsLevelBelow(4) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToHand()
end
function c9354555.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c9354555.tdfilter,tp,LOCATION_HAND,0,3,nil)
		and Duel.IsExistingMatchingCard(c9354555.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,3,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c9354555.rescon(sg,e,tp,mg)
	return #sg<2 or sg:GetClassCount(Card.GetCode)==1
end
function c9354555.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c9354555.tdfilter,tp,LOCATION_HAND,0,3,3,nil)
	if #g<3 then return end
	Duel.ConfirmCards(1-tp,g)
	if Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=3
		or not g:IsExists(Card.IsLocation,3,nil,LOCATION_DECK) then return end
	local sg=Duel.GetMatchingGroup(c9354555.thfilter,tp,LOCATION_DECK,0,nil)
	if #sg==0 then return end
	local hg=aux.SelectUnselectGroup(sg,e,tp,1,3,c9354555.rescon,1,tp,HINTMSG_ATOHAND)
	if #hg>0 then
		Duel.BreakEffect()
		Duel.SendtoHand(hg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,hg)
	end
end