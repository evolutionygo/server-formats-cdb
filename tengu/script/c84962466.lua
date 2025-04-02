--ビーストライザー
--Beast Rising
function c84962466.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--Increase the ATK of 1 Beast or Beast-Warrior monster you control
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc84962466(c84962466,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_SZONE)
	e1:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP|TIMING_END_PHASE)
	e1:SetCountLimit(1)
	e1:SetCondition(function() return not (Duel.IsPhase(PHASE_DAMAGE) and Duel.IsDamageCalculated()) end)
	e1:SetCost(c84962466.atkcost)
	e1:SetTarget(c84962466.atktg)
	e1:SetOperation(c84962466.atkop)
	c:RegisterEffect(e1)
end
function c84962466.atkcostfilter(c,tp)
	return c:IsRace(RACE_BEAST|RACE_BEASTWARRIOR) and c:IsFaceup() and c:IsAbleToRemoveAsCost() and c:GetTextAttack()>0
		and Duel.IsExistingTarget(aux.FaceupFilter(Card.IsRace,RACE_BEAST|RACE_BEASTWARRIOR),tp,LOCATION_MZONE,0,1,c)
end
function c84962466.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84962466.atkcostfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c84962466.atkcostfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabel(g:GetFirst():GetTextAttack())
end
function c84962466.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() and chkc:IsRace(RACE_BEAST|RACE_BEASTWARRIOR) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATKDEF)
	Duel.SelectTarget(tp,aux.FaceupFilter(Card.IsRace,RACE_BEAST|RACE_BEASTWARRIOR),tp,LOCATION_MZONE,0,1,1,nil)
end
function c84962466.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsControler(tp)
		and tc:IsRace(RACE_BEAST|RACE_BEASTWARRIOR) then
		--Gains ATK equal to the original ATK of the monster banished to activate this effect
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT|RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end