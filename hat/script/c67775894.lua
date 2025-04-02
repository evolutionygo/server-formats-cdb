--ワンダー・ワンド
--Wonder Wand
function c67775894.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER))
	--increase ATK
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	--send to the gy and draw
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc67775894(c67775894,0))
	e4:SetCategory(CATEGORY_DRAW)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCost(c67775894.drcost)
	e4:SetTarget(c67775894.drtg)
	e4:SetOperation(c67775894.drop)
	c:RegisterEffect(e4)
end
function c67775894.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	if chk==0 then return c:IsAbleToGraveAsCost() and ec and c:GetControler()==ec:GetControler()
		and ec:IsAbleToGraveAsCost() end
	local g=Group.FromCards(c,ec)
	Duel.SendtoGrave(g,REASON_COST)
end
function c67775894.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c67775894.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end