--オノマト連携
--Onomatopaira
function c6595475.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,c6595475,EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c6595475.cost)
	e1:SetTarget(c6595475.target)
	e1:SetOperation(c6595475.activate)
	c:RegisterEffect(e1)
end
c6595475.listed_series={0x54,0x59,0x82,0x8f}
function c6595475.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsAbleToGraveAsCost,1,1,REASON_COST)
end
function c6595475.filter(c)
	return c:IsMonster() and (c:IsSetCard(0x54) or c:IsSetCard(0x59) or c:IsSetCard(0x82) or c:IsSetCard(0x8f)) and c:IsAbleToHand()
end
function c6595475.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6595475.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c6595475.rescon(sg,e,tp,mg)
	local t={0x54,0x59,0x82,0x8f}
	local count = 0
	for i, set in ipairs(t) do
		if sg:IsExists(Card.IsSetCard,1,nil,set) then count = count + 1 end
	end
	return count >= #sg
end
function c6595475.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c6595475.filter,tp,LOCATION_DECK,0,nil)
	if #g==0 then return end
	local tg=aux.SelectUnselectGroup(g,e,tp,1,2,c6595475.rescon,1,tp,HINTMSG_ATOHAND)
	if #tg==0 then return end
	Duel.SendtoHand(tg,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,tg)
end