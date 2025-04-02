--電脳増幅器
--Amplifier
function c303660.initial_effect(c)
	--Equip
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsCode,CARD_JINZO),nil,nil,nil,nil,nil,EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	--Immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e1:SetTarget(c303660.etarget)
	e1:SetValue(c303660.efilter)
	c:RegisterEffect(e1)
	--Destroy the equipped monster when this card leaves the field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(c303660.desop)
	c:RegisterEffect(e2)
	--Effect cannot be negated
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_DISABLE)
	c:RegisterEffect(e3)
end
c303660.listed_names={CARD_JINZO}
function c303660.etarget(e,c)
	local ec=e:GetHandler():GetEquipTarget()
	return c:IsTrap() and ec and c:GetControler()==ec:GetControler()
end
function c303660.efilter(e,re)
	return re:GetHandler()==e:GetHandler():GetEquipTarget()
end
function c303660.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end