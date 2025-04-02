--立炎星－トウケイ
--Brotherhood of the Fire Fist - Rooster
function c30929786.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc30929786(c30929786,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,c30929786)
	e1:SetCondition(c30929786.thcon)
	e1:SetTarget(c30929786.thtg)
	e1:SetOperation(c30929786.thop)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc30929786(c30929786,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c30929786.setcost)
	e2:SetOperation(c30929786.setop)
	c:RegisterEffect(e2)
end
c30929786.listed_series={0x79,0x7c}
function c30929786.thcon(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler():IsSetCard(0x79) and re:GetHandler():IsMonster()
end
function c30929786.thfilter(c)
	return c:IsSetCard(0x79) and c:IsMonster() and c:IsAbleToHand()
end
function c30929786.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c30929786.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c30929786.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c30929786.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c30929786.cfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x7c) and c:IsSpellTrap() and c:IsAbleToGraveAsCost()
		and ((c:GetSequence()<5 and Duel.IsExistingMatchingCard(c30929786.filter,tp,LOCATION_DECK,0,1,nil,true))
		or (c:GetSequence()>4 and Duel.IsExistingMatchingCard(c30929786.filter,tp,LOCATION_DECK,0,1,nil)))
end
function c30929786.filter(c,ignore)
	return c:IsSetCard(0x7c) and c:IsSpellTrap() and c:IsSSetable(ignore)
end
function c30929786.setcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local nc=Duel.IsExistingMatchingCard(c30929786.cfilter,tp,LOCATION_ONFIELD,0,1,nil,tp) and Duel.GetLocationCount(tp,LOCATION_SZONE)>-1
	if chk==0 then return nc or (Duel.IsPlayerAffectedByEffect(tp,CARD_FIRE_FIST_EAGLE) and Duel.IsExistingMatchingCard(c30929786.filter,tp,LOCATION_DECK,0,1,nil)) end
	if nc and not (Duel.IsPlayerAffectedByEffect(tp,CARD_FIRE_FIST_EAGLE) and Duel.IsExistingMatchingCard(c30929786.filter,tp,LOCATION_DECK,0,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringc30929786(CARD_FIRE_FIST_EAGLE,0))) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,c30929786.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
		Duel.SendtoGrave(g,REASON_COST)
	end
end
function c30929786.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c30929786.filter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SSet(tp,g:GetFirst())
	end
end