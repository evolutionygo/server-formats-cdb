--バリア・リゾネーター
--Barrier Resonator
function c89127526.initial_effect(c)
	--Apply an effect on 1 Tuner monster you control
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc89127526(c89127526,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetCondition(function() return Duel.IsAbleToEnterBP() or (Duel.IsBattlePhase() and not Duel.IsPhase(PHASE_BATTLE)) end)
	e1:SetCost(Cost.SelfToGrave)
	e1:SetTarget(c89127526.efftg)
	e1:SetOperation(c89127526.effop)
	c:RegisterEffect(e1)
end
function c89127526.tgfilter(c)
	return c:IsType(TYPE_TUNER) and c:IsFaceup() and not c:HasFlagEffect(c89127526)
end
function c89127526.efftg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c89127526.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c89127526.tgfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_APPLYTO)
	Duel.SelectTarget(tp,c89127526.tgfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c89127526.effop(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		tc:RegisterFlagEffect(c89127526,RESETS_STANDARD_PHASE_END,0,1)
		--It cannot be destroyed by battle this turn
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringc89127526(c89127526,1))
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESETS_STANDARD_PHASE_END)
		tc:RegisterEffect(e1)
		--You take no battle damage from attacks involving it this turn
		local e2=e1:Clone()
		e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		tc:RegisterEffect(e2)
	end
end