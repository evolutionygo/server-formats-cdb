--あまびえさん
--Amabie-san (Rush)
function c160407001.initial_effect(c)
	--LP recover
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c160407001.target)
	e1:SetOperation(c160407001.operation)
	c:RegisterEffect(e1)
end
function c160407001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,PLAYER_ALL,300)
end
function c160407001.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(tp,300,REASON_EFFECT)
	Duel.Recover(1-tp,300,REASON_EFFECT)
end