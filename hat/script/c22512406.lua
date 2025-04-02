--覆面忍者ヱビス
--Masked Ninja Ebisu
function c22512406.initial_effect(c)
	--Return Spells/Traps your opponent controls to the hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc22512406(c22512406,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c22512406.thcon)
	e1:SetTarget(c22512406.thtg)
	e1:SetOperation(c22512406.thop)
	c:RegisterEffect(e1)
end
c22512406.listed_series={SET_NINJA}
c22512406.listed_names={c22512406,10236520}
function c22512406.confilter(c)
	return c:IsSetCard(SET_NINJA) and c:IsFaceup() and not c:IsCode(c22512406)
end
function c22512406.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c22512406.confilter,tp,LOCATION_MZONE,0,1,nil)
end
function c22512406.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(aux.FaceupFilter(Card.IsSetCard,SET_NINJA),tp,LOCATION_MZONE,0,nil)
	if chk==0 then return ct>0 and Duel.IsExistingMatchingCard(aux.AND(Card.IsSpellTrap,Card.IsAbleToHand),tp,0,LOCATION_ONFIELD,ct,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,ct,1-tp,LOCATION_ONFIELD)
end
function c22512406.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--Each of your "Goe Goe the Gallant Ninja" can attack directly this turn
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsCode,10236520))
	e1:SetReset(RESET_PHASE|PHASE_END)
	Duel.RegisterEffect(e1,tp)
	aux.RegisterClientHint(c,0,tp,1,0,aux.Stringc22512406(c22512406,1))
	local ct=Duel.GetMatchingGroupCount(aux.FaceupFilter(Card.IsSetCard,SET_NINJA),tp,LOCATION_MZONE,0,nil)
	if ct==0 then return end
	local g=Duel.GetMatchingGroup(aux.AND(Card.IsSpellTrap,Card.IsAbleToHand),tp,0,LOCATION_ONFIELD,nil)
	if ct>#g then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local sg=g:Select(tp,ct,ct,nil)
	if #sg==0 then return end
	Duel.HintSelection(sg,true)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
end