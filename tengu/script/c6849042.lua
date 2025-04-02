--超古代恐獣
--Super-Ancient Dinobeast
function c6849042.initial_effect(c)
	--summon with 1 tribute
	local e1=aux.AddNormalSummonProcedure(c,true,true,1,1,SUMMON_TYPE_TRIBUTE,aux.Stringc6849042(c6849042,0),c6849042.otfilter)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc6849042(c6849042,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c6849042.drcon)
	e2:SetTarget(c6849042.drtg)
	e2:SetOperation(c6849042.drop)
	c:RegisterEffect(e2)
end
function c6849042.otfilter(c,tp)
	return c:IsRace(RACE_DINOSAUR) and (c:IsControler(tp) or c:IsFaceup())
end
function c6849042.cfilter(c,tp)
	return c:IsRace(RACE_DINOSAUR) and c:IsPreviousLocation(LOCATION_GRAVE)
		and c:IsPreviousControler(tp)
end
function c6849042.drcon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c6849042.cfilter,1,nil,tp)
end
function c6849042.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c6849042.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end