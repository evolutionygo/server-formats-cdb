--漆黒のパワーストーン
--Pitch-Black Power Stone
function c34029630.initial_effect(c)
	c:EnableCounterPermit(COUNTER_SPELL)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetTarget(c34029630.target)
	e2:SetOperation(c34029630.operation)
	c:RegisterEffect(e2)
	--counter
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc34029630(c34029630,1))
	e3:SetCategory(CATEGORY_COUNTER)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1)
	e3:SetCondition(c34029630.condition)
	e3:SetTarget(c34029630.target2)
	e3:SetOperation(c34029630.operation)
	c:RegisterEffect(e3)
	--self destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EFFECT_SELF_DESTROY)
	e4:SetCondition(c34029630.descon)
	c:RegisterEffect(e4)
end
c34029630.counter_place_list={COUNTER_SPELL}
function c34029630.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c34029630.filter(chkc) end
	local c=e:GetHandler()
	if chk==0 then return Duel.IsCanAddCounter(tp,COUNTER_SPELL,3,c) end
	c:AddCounter(COUNTER_SPELL,3)
	if not Duel.IsDuelType(DUEL_USE_TRAPS_IN_NEW_CHAIN) and c34029630.condition(e,tp,eg,ep,ev,re,r,rp) and c34029630.target2(e,tp,eg,ep,ev,re,r,rp,0,chkc)
		and Duel.SelectEffectYesNo(tp,c,94) then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringc34029630(c34029630,2))
		Duel.SelectTarget(tp,c34029630.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,c)
		c:RegisterFlagEffect(0,RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,65)
		c:RegisterFlagEffect(c34029630,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	else
		e:SetProperty(0)
	end
end
function c34029630.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and c:IsCanRemoveCounter(tp,COUNTER_SPELL,1,REASON_EFFECT) and tc:IsCanAddCounter(COUNTER_SPELL,1) then
		c:RemoveCounter(tp,COUNTER_SPELL,1,REASON_EFFECT)
		tc:AddCounter(COUNTER_SPELL,1)
	end
end
function c34029630.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c34029630.filter(c)
	return c:IsFaceup() and c:IsCanAddCounter(COUNTER_SPELL,1)
end
function c34029630.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c34029630.filter(chkc) end
	if chk==0 then return e:GetHandler():GetFlagEffect(c34029630)==0 and e:GetHandler():IsCanRemoveCounter(tp,COUNTER_SPELL,1,REASON_EFFECT)
		and Duel.IsExistingTarget(c34029630.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringc34029630(c34029630,2))
	Duel.SelectTarget(tp,c34029630.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
end
function c34029630.descon(e)
	return e:GetHandler():GetCounter(COUNTER_SPELL)==0
end