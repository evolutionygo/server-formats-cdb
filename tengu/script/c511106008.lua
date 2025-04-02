--ジェムナイトレディ・ラピスラズリ
--Gem-Knight Lady Lapis Lazuli (Anime)
--scripted by Hatter
function c511106008.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,81846636,aux.FilterBoolFunctionEx(Card.IsSetCard,0x1047))
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511106008.damtg)
	e1:SetCost(c511106008.damcost)
	e1:SetOperation(c511106008.damop)
	c:RegisterEffect(e1)
end
c511106008.material_setcode={0x47,0x1047}
function c511106008.filter(c,e)
	local name=e:GetHandler():GetCode()
	return c:IsCode(name) and c:IsAbleToGraveAsCost()
end
function c511106008.ctfilter(c)
	return c:IsSummonType(SUMMON_TYPE_SPECIAL) and c:IsSummonLocation(LOCATION_EXTRA)
end
function c511106008.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511106008.filter,tp,LOCATION_EXTRA,0,1,nil,e) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511106008.filter,tp,LOCATION_EXTRA,0,1,1,nil,e)
	if #g>0 then
		Duel.SendtoGrave(g,REASON_COST)
	end
end
function c511106008.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetMatchingGroupCount(c511106008.ctfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local dam=(e:GetHandler():GetAttack()/2)+(ct*100)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511106008.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end