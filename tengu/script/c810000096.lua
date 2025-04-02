--妖仙大旋風 (Anime)
--Yosen Whirlwind (Anime)
--Original script by: UnknownGuest
--End phase effect added by: senpaizuri, rescripted by Larry126
function c810000096.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c810000096.cost)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_TO_HAND)
	e2:SetCondition(c810000096.condition)
	e2:SetOperation(c810000096.operation)
	c:RegisterEffect(e2)
	--self destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c810000096.descon)
	e3:SetOperation(c810000096.desop)
	c:RegisterEffect(e3)
end
c810000096.listed_series={0xb3}
function c810000096.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)
end
function c810000096.cfilter(c,p)
	return c:IsSetCard(0xb3) and c:IsPreviousControler(p)
		and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP)
end
function c810000096.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c810000096.cfilter,1,nil,tp)
end
function c810000096.operation(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(c810000096,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	local ct=eg:FilterCount(c810000096.cfilter,nil,tp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,nil)
	if #g>=ct and Duel.SelectEffectYesNo(tp,e:GetHandler()) then
		Duel.Hint(HINT_CARD,1-tp,c810000096)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local rg=g:Select(tp,ct,ct,nil)
		Duel.HintSelection(rg)
		Duel.SendtoHand(rg,nil,REASON_EFFECT)
	end
end
function c810000096.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and e:GetHandler():GetFlagEffect(c810000096)==0
end
function c810000096.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end