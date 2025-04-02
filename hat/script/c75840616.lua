--武神帝－スサノヲ
--Bujintei Susanowo
function c75840616.initial_effect(c)
	c:SetUniqueOnField(1,0,c75840616)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x88),4,2)
	c:EnableReviveLimit()
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_DECKDES)
	e1:SetDescription(aux.Stringc75840616(c75840616,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c75840616.cost)
	e1:SetTarget(c75840616.target)
	e1:SetOperation(c75840616.operation)
	c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
	--attack all
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_ATTACK_ALL)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
c75840616.listed_series={0x88}
function c75840616.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c75840616.filter(c)
	return c:IsSetCard(0x88) and c:IsMonster() and (c:IsAbleToHand() or c:IsAbleToGrave())
end
function c75840616.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75840616.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c75840616.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c75840616.filter,tp,LOCATION_DECK,0,1,1,nil)
	aux.ToHandOrElse(g:GetFirst(),tp)
end