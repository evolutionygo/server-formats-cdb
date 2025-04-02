--ZW－雷神猛虎剣
--ZW - Lightning Blade
function c45082499.initial_effect(c)
	c:SetUniqueOnField(1,0,c45082499)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc45082499(c45082499,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e1:SetCondition(c45082499.eqcon)
	e1:SetTarget(c45082499.eqtg)
	e1:SetOperation(c45082499.eqop)
	c:RegisterEffect(e1)
	aux.AddZWEquipLimit(c,c45082499.eqcon,function(tc,c,tp) return c45082499.filter(tc) and tc:IsControler(tp) end,c45082499.equipop,e1)
	--"ZW" cards cannot be destroyed by your opponent's effects while this card is equipped to a monster
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_ONFIELD,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,SET_ZW))
	e2:SetCondition(function(e) return e:GetHandler():GetEquipTarget() end)
	e2:SetValue(aux.indoval)
	c:RegisterEffect(e2)
	--Destruction replacement for the equipped monster
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCode(EFFECT_DESTROY_SUBSTITUTE)
	e3:SetValue(c45082499.repval)
	c:RegisterEffect(e3)
end
c45082499.listed_series={SET_UTOPIA,SET_ZW}
function c45082499.eqcon(e)
	return e:GetHandler():CheckUniqueOnField(e:GetHandlerPlayer())
end
function c45082499.filter(c)
	return c:IsFaceup() and c:IsSetCard(SET_UTOPIA)
end
function c45082499.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c45082499.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c45082499.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c45082499.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c45082499.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if c:IsLocation(LOCATION_MZONE) and c:IsFacedown() then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or not tc:IsRelateToEffect(e) or tc:IsFacedown() or tc:GetControler()~=tp or not c:CheckUniqueOnField(tp) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	c45082499.equipop(c,e,tp,tc)
end
function c45082499.equipop(c,e,tp,tc)
	if not aux.EquipAndLimitRegister(c,e,tp,tc) then return end
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(1200)
	e1:SetReset(RESET_EVENT|RESETS_STANDARD)
	c:RegisterEffect(e1)
end
function c45082499.repval(e,re,r,rp)
	return (r&REASON_EFFECT)~=0
end