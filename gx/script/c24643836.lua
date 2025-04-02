--おジャマジック
--Ojamagic
function c24643836.initial_effect(c)
	--Add 1 each of "Ojama Green", "Ojama Yellow", and "Ojama Black" from your Deck to your hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc24643836(c24643836,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(function(e) return e:GetHandler():IsPreviousLocation(LOCATION_HAND|LOCATION_ONFIELD) end)
	e1:SetTarget(c24643836.thtg)
	e1:SetOperation(c24643836.thop)
	c:RegisterEffect(e1)
end
c24643836.listed_names={12482652,42941100,79335209} --"Ojama Green", "Ojama Yellow", "Ojama Black"
function c24643836.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,3,tp,LOCATION_DECK)
end
function c24643836.thfilter(c)
	return c:IsCode(12482652,42941100,79335209) and c:IsAbleToHand()
end
function c24643836.rescon(sg,e,tp,mg)
	return sg:IsExists(Card.IsCode,1,nil,12482652)
		and sg:IsExists(Card.IsCode,1,nil,42941100)
		and sg:IsExists(Card.IsCode,1,nil,79335209)
end
function c24643836.thop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c24643836.thfilter,tp,LOCATION_DECK,0,nil)
	if #sg<3 then return end
	local g=aux.SelectUnselectGroup(sg,e,tp,3,3,c24643836.rescon,1,tp,HINTMSG_ATOHAND)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end