--エレメンタル・アブソーバー
--Elemental Absorber
function c94253609.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c94253609.target)
	e1:SetOperation(c94253609.operation)
	c:RegisterEffect(e1)
	--Opponent's monsters with the same Attribute cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetTarget(c94253609.atktarget)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
function c94253609.cfilter(c)
	return c:IsMonster() and c:IsAbleToRemove()
end
function c94253609.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c94253609.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_HAND)
end
function c94253609.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c94253609.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	if #g>0 then
		Duel.Remove(g,POS_FACEUP,REASON_COST)
		local att=g:GetFirst():GetAttribute()
		e:GetLabelObject():SetLabel(att)
		e:GetHandler():SetHint(CHINT_ATTRIBUTE,att)
	end
end
function c94253609.atktarget(e,c)
	return c:IsAttribute(e:GetLabel())
end