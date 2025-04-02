--キャッスル・ゲート
--Castle Gate
function c36931229.initial_effect(c)
	--Cannot be destroyed by battle
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--Tribute 1 Level 5 or lower monster to inflict damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc36931229(c36931229,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(function(e) return e:GetHandler():IsAttackPos() end)
	e2:SetCost(c36931229.cost)
	e2:SetTarget(c36931229.target)
	e2:SetOperation(c36931229.operation)
	c:RegisterEffect(e2)
end
function c36931229.cfilter(c)
	return c:IsLevelBelow(5) and c:GetTextAttack()>0
end
function c36931229.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,c36931229.cfilter,1,false,nil,nil) end
	local sg=Duel.SelectReleaseGroupCost(tp,c36931229.cfilter,1,1,false,nil,nil)
	e:SetLabel(sg:GetFirst():GetTextAttack())
	Duel.Release(sg,REASON_COST)
end
function c36931229.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel())
end
function c36931229.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end