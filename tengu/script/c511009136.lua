--超銀河眼の光波龍 (Anime)
--Neo Galaxy-Eyes Cipher Dragon (Anime)
function c511009136.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,9,3)
	c:EnableReviveLimit()
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL+CATEGORY_ATKCHANGE)
	e1:SetDescription(aux.Stringc511009136(c511009136,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511009136.cost)
	e1:SetTarget(c511009136.target)
	e1:SetOperation(c511009136.operation)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetTargetRange(LOCATION_ONFIELD,0)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetLabel(511001822)
	e2:SetCondition(c511009136.efcon)
	e2:SetTarget(c511009136.eftg)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2,false,REGISTER_FLAG_DETACH_XMAT)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_MATERIAL_CHECK)
	e3:SetValue(c511009136.valcheck)
	c:RegisterEffect(e3)
	--return control
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_CONTROL)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetCondition(c511009136.ctcon)
	e4:SetTarget(c511009136.cttg)
	e4:SetOperation(c511009136.ctop)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_LEAVE_FIELD_P)
	e5:SetOperation(c511009136.op)
	e5:SetLabelObject(e4)
	c:RegisterEffect(e5)
end
c511009136.listed_names={18963306,c511009136}
function c511009136.efcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ) and e:GetHandler():GetFlagEffect(c511009136)>0
end
function c511009136.eftg(e,c)
	return c==e:GetHandler()
end
function c511009136.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsSummonCode,1,nil,c,SUMMON_TYPE_XYZ,c:GetSummonPlayer(),18963306) then
		c:RegisterFlagEffect(c511009136,RESET_EVENT+RESETS_STANDARD_DISABLE-RESET_TOFIELD,0,1)
	end
end
function c511009136.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=e:GetHandler():GetOverlayCount()
	if chk==0 then return ct>0 and e:GetHandler():CheckRemoveOverlayCard(tp,ct,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,ct,ct,REASON_COST)
end
function c511009136.filter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged()
end
function c511009136.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511009136.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,1,1-tp,LOCATION_MZONE)
end
function c511009136.operation(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectMatchingCard(tp,c511009136.filter,tp,0,LOCATION_MZONE,ft,ft,nil)
	for tc in aux.Next(g) do
		if Duel.GetControl(tc,tp) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			tc:RegisterEffect(e2)
			local e3=e2:Clone()
			e3:SetCode(EFFECT_SET_ATTACK_FINAL)
			e3:SetValue(c:GetAttack())
			tc:RegisterEffect(e3)
		end
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_CHANGE_CODE)
		e4:SetReset(RESET_EVENT+RESETS_STANDARD)
		e4:SetValue(c511009136)
		tc:RegisterEffect(e4)
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_SINGLE)
		e5:SetCode(EFFECT_CANNOT_ATTACK)
		e5:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e5)
		tc:CreateRelation(c,RESET_EVENT+RESETS_STANDARD)
	end
end
----return control
function c511009136.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabel()==1 and e:GetHandler():IsPreviousPosition(POS_FACEUP)
end
function c511009136.ctfilter(c,rc)
	return c:GetControler()~=c:GetOwner() and c:IsRelateToCard(rc)
end
function c511009136.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009136.ctfilter,tp,LOCATION_MZONE,0,1,nil,e:GetHandler()) end
end
function c511009136.ctop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511009136.ctfilter,tp,LOCATION_MZONE,0,nil,e:GetHandler())
	for tc in aux.Next(g) do
		if not tc:IsImmuneToEffect(e) then
			tc:ResetEffect(EFFECT_SET_CONTROL,RESET_CODE)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_CONTROL)
			e1:SetValue(tc:GetOwner())
			e1:SetReset(RESET_EVENT+RESETS_STANDARD-(RESET_TOFIELD+RESET_TEMP_REMOVE+RESET_TURN_SET))
			tc:RegisterEffect(e1)
		end
	end
end
function c511009136.op(e,tp,eg,ep,ev,re,r,rp)
	if c511009136.efcon(e) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end