--武神集結
--Bujinunity
function c33611061.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_HANDES+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,c33611061,EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c33611061.condition)
	e1:SetTarget(c33611061.target)
	e1:SetOperation(c33611061.activate)
	c:RegisterEffect(e1)
end
c33611061.listed_series={0x88}
function c33611061.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(nil,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
end
function c33611061.filter(c)
	return c:IsSetCard(0x88) and c:IsRace(RACE_BEASTWARRIOR) and c:IsAbleToDeck()
end
function c33611061.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33611061.filter,tp,LOCATION_GRAVE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c33611061.filter,tp,LOCATION_GRAVE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,#g,0,0)
	Duel.SetPossibleOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c33611061.thfilter(c)
	return c:IsSetCard(0x88) and c:IsRace(RACE_BEASTWARRIOR) and c:IsAbleToHand()
end
function c33611061.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetMatchingGroup(c33611061.filter,tp,LOCATION_GRAVE,0,nil)
	if #tg>0 then
		Duel.SendtoDeck(tg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		Duel.SendtoGrave(hg,REASON_EFFECT)
		Duel.BreakEffect()
		local g=Duel.GetMatchingGroup(c33611061.thfilter,tp,LOCATION_DECK,0,nil)
		if #g==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g1=g:Select(tp,1,1,nil)
		g:Remove(Card.IsCode,nil,g1:GetFirst():GetCode())
		if #g>0 and Duel.SelectYesNo(tp,aux.Stringc33611061(c33611061,0)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local g2=g:Select(tp,1,1,nil)
			g:Remove(Card.IsCode,nil,g2:GetFirst():GetCode())
			g1:Merge(g2)
			if #g>0 and Duel.SelectYesNo(tp,aux.Stringc33611061(c33611061,0)) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
				local g3=g:Select(tp,1,1,nil)
				g1:Merge(g3)
			end
		end
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g1)
	end
end