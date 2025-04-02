--地底のアラクネー
--Underground Arachnc100000154 (VG)
function c100000154.initial_effect(c)
	c:AddSetcodesRule(c100000154,false,0x601)
	--Dark Synchro procedure
	c:EnableReviveLimit()
	Synchro.AddDarkSynchroProcedure(c,aux.NonTuner(nil),nil,6)
	--Prevent activations when it attacks
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c100000154.aclimit)
	e1:SetCondition(c100000154.actcon)
	c:RegisterEffect(e1)
	--Equip 1 opponent's monster
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc100000154(c100000154,0))
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c100000154.eqcon)
	e2:SetTarget(c100000154.eqtg)
	e2:SetOperation(c100000154.eqop)
	c:RegisterEffect(e2)
	aux.AddEREquipLimit(c,c100000154.eqcon,function(ec,_,tp) return ec:IsControler(1-tp) end,c100000154.equipop,e2)
end
function c100000154.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c100000154.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
function c100000154.eqcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetEquipGroup():Filter(c100000154.eqfilter,nil)
	return #g==0
end
function c100000154.eqfilter(c)
	return c:GetFlagEffect(c100000154)~=0 
end
function c100000154.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToChangeControler() end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c100000154.equipop(c,e,tp,tc)
	if not c:EquipByEffectAndLimitRegister(e,tp,tc,c100000154) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_DESTROY_SUBSTITUTE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(1)
	tc:RegisterEffect(e1)
end
function c100000154.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			c100000154.equipop(c,e,tp,tc)
		else
			Duel.SendtoGrave(tc,REASON_EFFECT)
		end
	end
end