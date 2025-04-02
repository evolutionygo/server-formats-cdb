--エーリアン・ヒュプノ
--Alien Hypno
function c38468214.initial_effect(c)
	Gemini.AddProcedure(c)
	--Take control of 1 monster with an A-Counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc38468214(c38468214,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(Gemini.EffectStatusCondition)
	e1:SetTarget(c38468214.target)
	e1:SetOperation(c38468214.operation)
	c:RegisterEffect(e1)
end
c38468214.counter_list={COUNTER_A}
function c38468214.filter(c)
	return c:GetCounter(COUNTER_A)>0 and c:IsControlerCanBeChanged()
end
function c38468214.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c38468214.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c38468214.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c38468214.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c38468214.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:GetCounter(COUNTER_A)>0 and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		c:SetCardTarget(tc)
		--Change control
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_SET_CONTROL)
		e1:SetCondition(c38468214.ctcon)
		e1:SetValue(tp)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD)
		tc:RegisterEffect(e1)
		--Remove A-Counters on End Phase
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCountLimit(1)
		e2:SetCondition(function(e,tp) return Duel.IsTurnPlayer(tp) end)
		e2:SetOperation(c38468214.rmctop)
		e2:SetReset(RESET_EVENT|RESETS_STANDARD)
		tc:RegisterEffect(e2)
		--Destroy monster if it has no A-Counters
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_SELF_DESTROY)
		e3:SetCondition(function(e) return e:GetHandler():GetCounter(COUNTER_A)==0 end)
		e3:SetReset(RESET_EVENT|RESETS_STANDARD)
		tc:RegisterEffect(e3)
	end
end
function c38468214.ctcon(e)
	local c=e:GetOwner()
	return c:IsHasCardTarget(e:GetHandler()) and not c:IsDisabled()
end
function c38468214.rmctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:RemoveCounter(tp,COUNTER_A,1,REASON_EFFECT)
	Duel.RaiseEvent(c,EVENT_REMOVE_COUNTER+COUNTER_A,e,REASON_EFFECT,tp,tp,1)
end