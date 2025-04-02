--ＣＸ 機装魔人エンジェネラル (Anime)
--CXyz Mechquipped Djinn Angeneral (Anime)
--Scripted by Larry126
Duel.LoadCardScript("c41309158.lua")
function c511600284.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,3)
	c:EnableReviveLimit()
	--Rank Up Check
	aux.EnableCheckRankUp(c,nil,nil,15914410)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511600284(c511600284,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511600284.damcon)
	e1:SetCost(c511600284.damcost)
	e1:SetTarget(c511600284.damtg)
	e1:SetOperation(c511600284.damop)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_RANKUP_EFFECT)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2,false,REGISTER_FLAG_DETACH_XMAT)
end
c511600284.listed_names={15914410}
function c511600284.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c511600284.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ct=c:GetOverlayCount()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,ct,REASON_COST) end
	c:RemoveOverlayCard(tp,ct,ct,REASON_COST)
	e:SetLabel(ct)
end
function c511600284.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=e:GetLabel()*500
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511600284.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end