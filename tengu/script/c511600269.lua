--海晶乙女瀑布 (Anime)
--Marincess Cascade (Anime)
--scripted by Larry126
function c511600269.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511600269(c511600269,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+TIMINGS_CHECK_MONSTER)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCost(c511600269.cost)
	e1:SetTarget(c511600269.target)
	e1:SetOperation(c511600269.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c511600269.handcon)
	e2:SetDescription(aux.Stringc511600269(c511600269,1))
	c:RegisterEffect(e2)
end
c511600269.listed_series={0x12b}
function c511600269.cfilter(c)
	return c:IsFaceup() and c:IsLinkMonster() and c:IsSetCard(0x12b)
end
function c511600269.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c511600269.cfilter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return #g==g:FilterCount(Card.IsAbleToRemoveAsCost,nil) end
	if Duel.Remove(g,POS_FACEUP,REASON_COST+REASON_TEMPORARY)==#g then
		g:KeepAlive()
		e:SetLabelObject(g)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		if Duel.GetCurrentPhase()==PHASE_STANDBY then e1:SetLabel(Duel.GetTurnCount()) end
		e1:SetLabelObject(g)
		e1:SetCountLimit(1)
		e1:SetCondition(c511600269.retcon)
		e1:SetOperation(c511600269.retop)
		if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_STANDBY then e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,2)
		else e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN) end
		Duel.RegisterEffect(e1,tp)
	end
end
function c511600269.retcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetTurnCount()~=e:GetLabel()
end
function c511600269.retop(e,tp,eg,ep,ev,re,r,rp)
	for c in aux.Next(e:GetLabelObject()) do
		Duel.ReturnToField(c)
	end
end
function c511600269.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,nil,1,0,e:GetLabelObject():GetSum(Card.GetLink)*300)
end
function c511600269.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local tc=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil):GetFirst()
	if tc then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabelObject():GetSum(Card.GetLink)*300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c511600269.filter(c)
	return c:IsSetCard(0x22b) and not c:IsLinkMonster()
end
function c511600269.handcon(e)
	return Duel.IsExistingMatchingCard(c511600269.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end