--破壊神の系譜 (Anime)
--Lineage of Destruction (Anime)
--fixed by Larry126
function c511002484.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002484.condition)
	e1:SetTarget(c511002484.target)
	e1:SetOperation(c511002484.activate)
	c:RegisterEffect(e1)
	aux.GlobalCheck(s,function()
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DESTROYED)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetOperation(c511002484.checkop)
		Duel.RegisterEffect(ge1,0)
	end)
end
function c511002484.cfilter(c,p)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_DEFENSE) and c:IsPreviousControler(p)
end
function c511002484.checkop(e,tp,eg,ep,ev,re,r,rp)
	for p=0,1 do
		local tg=eg:Filter(c511002484.cfilter,nil,p)
		for tc in aux.Next(tg) do
			Duel.RegisterFlagEffect(1-p,c511002484,RESET_PHASE+PHASE_END,0,1)
		end
	end
end
function c511002484.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,c511002484)>0 and Duel.GetTurnPlayer()==tp and (Duel.IsAbleToEnterBP()
		or (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE))
end
function c511002484.filter(c)
	return c:IsFaceup() and (c:GetEffectCount(EFFECT_EXTRA_ATTACK)==0
		or c:GetEffectCount(EFFECT_EXTRA_ATTACK)<Duel.GetFlagEffect(tp,c511002484))
end
function c511002484.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511002484.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002484.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511002484.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511002484.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(Duel.GetFlagEffect(tp,c511002484))
		tc:RegisterEffect(e1)
	end
end