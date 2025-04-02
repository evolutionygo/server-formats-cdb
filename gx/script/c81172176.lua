--デビル・コメディアン
--Fiend Comedian
function c81172176.initial_effect(c)
	--Toss a coin and banish cards from the opponent's GY or send cards from Deck to the GY
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc81172176(c81172176,0))
	e1:SetCategory(CATEGORY_COIN+CATEGORY_REMOVE+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c81172176.target)
	e1:SetOperation(c81172176.activate)
	c:RegisterEffect(e1)
end
c81172176.toss_coin=true
function c81172176.rmfilter(c)
	return c:IsAbleToRemove() and aux.SpElimFilter(c)
end
function c81172176.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81172176.rmfilter,tp,0,LOCATION_MZONE|LOCATION_GRAVE,1,nil)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=Duel.GetFieldGroupCount(tp,0,LOCATION_GRAVE) end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
	Duel.SetPossibleOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_GRAVE)
	Duel.SetPossibleOperationInfo(0,CATEGORY_DECKDES,nil,1,tp,0)
end
function c81172176.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CallCoin(tp) then
		Duel.Remove(Duel.GetMatchingGroup(c81172176.rmfilter,tp,0,LOCATION_MZONE|LOCATION_GRAVE,nil),POS_FACEUP,REASON_EFFECT)
	else
		Duel.DiscardDeck(tp,Duel.GetFieldGroupCount(tp,0,LOCATION_GRAVE),REASON_EFFECT)
	end
end