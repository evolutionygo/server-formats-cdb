--サンダー・ドラゴン
--Thunder Dragon
--"“Thunder Dragon” may be discarded to search for 0 “Thunder Dragons” in the player’s deck." netrep ruling
function c504700054.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc504700054(c504700054,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c504700054.cost)
	e1:SetTarget(c504700054.target)
	e1:SetOperation(c504700054.operation)
	c:RegisterEffect(e1,false,REGISTER_FLAG_THUNDRA)
end
c504700054.listed_names={31786629}
function c504700054.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c504700054.filter(c)
	return c:IsCode(31786629) and c:IsAbleToHand()
end
function c504700054.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,0,tp,LOCATION_DECK)
end
function c504700054.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c504700054.filter,tp,LOCATION_DECK,0,0,2,nil)
	if g and #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	else
		if not Duel.IsExistingMatchingCard(c504700054.filter,tp,LOCATION_DECK,0,1,nil) then Duel.GoatConfirm(tp,LOCATION_DECK) end
	end
end