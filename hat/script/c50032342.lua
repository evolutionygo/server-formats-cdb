--氷結界の軍師
--Strategist of the Ice Barrier
function c50032342.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc50032342(c50032342,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(aux.IceBarrierDiscardCost(c50032342.cfilter,false))
	e1:SetTarget(c50032342.target)
	e1:SetOperation(c50032342.operation)
	c:RegisterEffect(e1)
end
c50032342.listed_series={0x2f}
function c50032342.cfilter(c)
	return c:IsSetCard(0x2f) and c:IsMonster()
end
function c50032342.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c50032342.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end