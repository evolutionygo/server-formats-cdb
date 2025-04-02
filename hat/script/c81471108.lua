--ZW－風神雲龍剣
--ZW - Tornado Bringer
function c81471108.initial_effect(c)
	c:SetUniqueOnField(1,0,c81471108)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc81471108(c81471108,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e1:SetCondition(c81471108.eqcon)
	e1:SetTarget(c81471108.eqtg)
	e1:SetOperation(c81471108.eqop)
	c:RegisterEffect(e1)
	aux.AddZWEquipLimit(c,c81471108.eqcon,function(tc,c,tp) return c81471108.filter(tc) and tc:IsControler(tp) end,c81471108.equipop,e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--destroy sub
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCode(EFFECT_DESTROY_SUBSTITUTE)
	e3:SetValue(c81471108.repval)
	c:RegisterEffect(e3)
end
c81471108.listed_series={0x107f}
function c81471108.eqcon(e)
	return e:GetHandler():CheckUniqueOnField(e:GetHandlerPlayer())
end
function c81471108.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x107f)
end
function c81471108.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c81471108.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c81471108.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c81471108.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c81471108.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if c:IsLocation(LOCATION_MZONE) and c:IsFacedown() then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or not tc:IsRelateToEffect(e) or tc:IsFacedown() or tc:GetControler()~=tp or not c:CheckUniqueOnField(tp) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	c81471108.equipop(c,e,tp,tc)
end
function c81471108.equipop(c,e,tp,tc)
	if not aux.EquipAndLimitRegister(c,e,tp,tc) then return end
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(1300)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
end
function c81471108.repval(e,re,r,rp)
	return (r&REASON_BATTLE)~=0
end