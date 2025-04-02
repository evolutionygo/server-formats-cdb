--No.33 先史遺産－超兵器マシュ＝マック (Anime)
--Number 33: Chronomaly Machu Mech (Anime)
Duel.EnableUnofficialProc(PROC_STATS_CHANGED)
Duel.LoadCardScript("c39139935.lua")
function c511002091.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,2)
	c:EnableReviveLimit()
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511002091(c511002091,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(511001265)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511002091.damcon)
	e1:SetCost(aux.dxmcostgen(1,1,nil))
	e1:SetTarget(c511002091.damtg)
	e1:SetOperation(c511002091.damop)
	c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(c511002091.indes)
	c:RegisterEffect(e3)
end
c511002091.aux.xyz_number=33
function c511002091.cfilter(c)
	local val=0
	if c:GetFlagEffect(284)>0 then val=c:GetFlagEffectLabel(284) end
	return c:GetAttack()~=val
end
function c511002091.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002091.cfilter,1,nil)
end
function c511002091.diffilter1(c,g)
	local dif=0
	local val=0
	if c:GetFlagEffect(284)>0 then val=c:GetFlagEffectLabel(284) end
	if c:GetAttack()>val then dif=c:GetAttack()-val
	else dif=val-c:GetAttack() end
	return g:IsExists(c511002091.diffilter2,1,c,dif)
end
function c511002091.diffilter2(c,dif)
	local dif2=0
	local val=0
	if c:GetFlagEffect(284)>0 then val=c:GetFlagEffectLabel(284) end
	if c:GetAttack()>val then dif2=c:GetAttack()-val
	else dif2=val-c:GetAttack() end
	return dif~=dif2
end
function c511002091.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ec=eg:GetFirst()
	local g=eg:Filter(c511002091.diffilter1,nil,eg)
	local g2=Group.CreateGroup()
	if #g>0 then g2=g:Select(tp,1,1,nil) ec=g2:GetFirst() end
	if #g2>0 then Duel.HintSelection(g2) end
	local dam=0
	local val=0
	if ec:GetFlagEffect(284)>0 then val=ec:GetFlagEffectLabel(284) end
	if ec:GetAttack()>val then dam=ec:GetAttack()-val
	else dam=val-ec:GetAttack() end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511002091.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511002091.indes(e,c)
	return not c:IsSetCard(SET_NUMBER)
end