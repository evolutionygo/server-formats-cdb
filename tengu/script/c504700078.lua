--カオスライダー グスタフ
--Chaosrc504700078er Gustaph (GOAT)
--Effect doesn't target
function c504700078.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc504700078(c504700078,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c504700078.target)
	e1:SetOperation(c504700078.operation)
	c:RegisterEffect(e1)
end
function c504700078.filter(c)
	return c:IsSpell() and c:IsAbleToRemove()
end
function c504700078.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c504700078.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c504700078.filter,tp,LOCATION_GRAVE,0,1,nil) end
end
function c504700078.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c504700078.filter,tp,LOCATION_GRAVE,0,1,2,nil)
	local count=Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	local c=e:GetHandler()
	if count>0 and c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(count*300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE+RESET_PHASE+PHASE_END,2)
		c:RegisterEffect(e1)
	end
end