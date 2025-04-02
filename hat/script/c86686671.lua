--サイバー・リペア・プラント
--Cyber Repair Plant
function c86686671.initial_effect(c)
	--Activate 1 of these effects
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc86686671(c86686671,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,c86686671,EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(function(e,tp) return Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,CARD_CYBER_DRAGON) end)
	e1:SetTarget(c86686671.target)
	e1:SetOperation(c86686671.activate)
	c:RegisterEffect(e1)
end
c86686671.listed_names={CARD_CYBER_DRAGON}
function c86686671.thfilter(c)
	return c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToHand()
end
function c86686671.tdfilter(c)
	return c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToDeck()
end
function c86686671.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return e:GetLabel()~=0 and chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c86686671.tdfilter(chkc) end
	local b1=Duel.IsExistingMatchingCard(c86686671.thfilter,tp,LOCATION_DECK,0,1,nil)
	local b2=Duel.IsExistingTarget(c86686671.tdfilter,tp,LOCATION_GRAVE,0,1,nil)
	local b3=b1 and b2 and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,3,nil,CARD_CYBER_DRAGON)
	if chk==0 then return b1 or b2 end
	local op=Duel.SelectEffect(tp,
		{b1,aux.Stringc86686671(c86686671,1)},
		{b2,aux.Stringc86686671(c86686671,2)},
		{b3,aux.Stringc86686671(c86686671,3)})
	e:SetLabel(op)
	local cat=0
	if op==1 or op==3 then
		cat=CATEGORY_TOHAND+CATEGORY_SEARCH
		e:SetCategory(cat)
		e:SetProperty(0)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	end
	if op==2 or op==3 then
		cat=cat|CATEGORY_TODECK
		e:SetCategory(cat)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectTarget(tp,c86686671.tdfilter,tp,LOCATION_GRAVE,0,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,tp,0)
	end
end
function c86686671.activate(e,tp,eg,ep,ev,re,r,rp)
	local op=e:GetLabel()
	local breakeff=false
	if op==1 or op==3 then
		--Add 1 LIGHT Machine monster from your Deck to your hand
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c86686671.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if #g>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
			breakeff=true
		end
	end
	if op==2 or op==3 then
		--Shuffle 1 LIGHT Machine monster from your GY into your Deck
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) then
			if breakeff then Duel.BreakEffect() end
			Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		end
	end
end