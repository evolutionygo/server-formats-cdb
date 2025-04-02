--ドン・サウザンドの契約 (Anime)
--Contract with Don Thousand (Anime)
function c511001186.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001186.cost)
	e1:SetTarget(c511001186.target)
	e1:SetOperation(c511001186.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_DRAW)
	e2:SetOperation(c511001186.cfop)
	c:RegisterEffect(e2)
end
function c511001186.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(1-tp,2000) end
	Duel.PayLPCost(1-tp,2000)
end
function c511001186.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) and Duel.IsPlayerCanDraw(1-tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,1)
end
function c511001186.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Draw(1-tp,1,REASON_EFFECT)
end
function c511001186.filter(c)
	return c:IsLocation(LOCATION_HAND) and not c:IsPublic()
end
function c511001186.cfop(e,tp,eg,ep,ev,re,r,rp)
	local cg=eg:Filter(c511001186.filter,nil)
	if ep == tp then
		Duel.ConfirmCards(1-tp,cg)
		Duel.ShuffleHand(tp)
	elseif ep == (1-tp) then
		Duel.ConfirmCards(tp,cg)
		Duel.ShuffleHand(1-tp)
	end
	local tc=cg:GetFirst()
	while tc do
		if tc:IsSpell() then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(aux.Stringc511001186(c511001186,0))
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
			e1:SetCode(EFFECT_CANNOT_SUMMON)
			e1:SetReset(RESET_PHASE|PHASE_END)
			e1:SetTargetRange(1,0)
			Duel.RegisterEffect(e1,tc:GetControler())
		end
		tc=cg:GetNext()
	end
end