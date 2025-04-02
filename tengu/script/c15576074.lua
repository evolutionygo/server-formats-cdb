--リゾネーター・エンジン
function c15576074.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c15576074.target)
	e1:SetOperation(c15576074.activate)
	c:RegisterEffect(e1)
end
c15576074.listed_series={0x57}
function c15576074.filter(c)
	return c:IsSetCard(0x57) and c:IsMonster() and c:IsAbleToDeck()
end
function c15576074.filter2(c)
	return c:GetLevel()==4 and c:IsAbleToHand()
end
function c15576074.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c15576074.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c15576074.filter2,tp,LOCATION_DECK,0,1,nil)
		and Duel.IsExistingTarget(c15576074.filter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c15576074.filter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,#g,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c15576074.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c15576074.filter2,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
	local g=Duel.GetTargetCards(e)
	if #g~=0 then
		Duel.SendtoDeck(g,nil,0,REASON_EFFECT)
	end
end